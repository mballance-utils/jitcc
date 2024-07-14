
import os
import sys
import ctypes
from ctypes import CDLL
from jitcc cimport decl
cimport debug_mgr.core as dm_core
from libc.stdint cimport intptr_t

cdef class JitCC(object):

    cpdef int addIncludePath(self, str path):
        return self._hndl.addIncludePath(path.encode())

    cpdef int addSysIncludePath(self, str path):
        return self._hndl.addSysIncludePath(path.encode())

    cpdef void definePreProcSym(self, str sym, str value):
        self._hndl.definePreProcSym(sym.encode, value.encode())

    cpdef void undefPreProcSym(self, str sym):
        self._hndl.undefPreProcSym(sym.encode())

    cpdef int addSrcFile(self, str path):
        return self._hndl.addSrcFile(path.encode())

    cpdef int addSrcStr(self, str src):
        return self._hndl_addSrcStr(src.encode())

    cpdef int addSymbol(self, str sym, val):
        return self._hndl.addSymbol(sym.encode(), NULL)

    cpdef int relocate(self):
        return self._hndl.relocate()

    cpdef getSymbol(self, str sym):
        return None
#        return self._hndl.getSymbol(sym.encode())

    @staticmethod
    cdef JitCC mk(decl.IJitCC *hndl, bool owned=True):
        ret = JitCC()
        ret._hndl = hndl
        ret_owned = owned
        return ret


cdef Factory _Factory_inst = None

cdef class Factory(object):

    cpdef init(self, dm_core.DebugMgr dmgr):
        self._hndl.init(dmgr._hndl)

    cpdef JitCC mkTinyCC(self):
        return JitCC.mk(self._hndl.mkTinyCC(), True)

    @staticmethod
    def inst():
        cdef decl.IFactory *hndl = NULL
        cdef Factory factory
        global _Factory_inst

        if _Factory_inst is None:
            ext_dir = os.path.dirname(os.path.abspath(__file__))
            build_dir = os.path.abspath(os.path.join(ext_dir, "../../build"))

            core_lib = None
            libname = "libjitcc.so"
            for libdir in ("lib", "lib64"):
                if os.path.isfile(os.path.join(build_dir, libdir, libname)):
                    core_lib = os.path.join(build_dir, libdir, libname)
                    break
            if core_lib is None:
                core_lib = os.path.join(ext_dir, libname)

            if not os.path.isfile(core_lib):
                raise Exception("Extension library core \"%s\" doesn't exist" % core_lib)
            
            so = ctypes.cdll.LoadLibrary(core_lib)
            func = so.jit_cc_getFactory
            func.restype = ctypes.c_void_p

            hndl = <decl.IFactoryP>(<intptr_t>(func()))
            factory = Factory()
            factory._hndl = hndl
            factory.init(dm_core.Factory.inst())
            _Factory_inst = factory

        return _Factory_inst
