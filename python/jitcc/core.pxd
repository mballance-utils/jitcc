
cimport debug_mgr.core as dm_core
from jitcc cimport decl
from libc.stdint cimport intptr_t
from libc.stdint cimport uintptr_t
from libc.stdint cimport int32_t
from libc.stdint cimport uint32_t
from libc.stdint cimport uint64_t
from libc.stdint cimport int64_t
from libcpp cimport bool
from libcpp.vector cimport vector as cpp_vector
from enum import IntFlag, IntEnum
cimport cpython.ref as cpy_ref

cdef class JitCC(object):
    cdef decl.IJitCC                *_hndl
    cdef bool                       _owned

    cpdef int addIncludePath(self, str path)
    cpdef int addSysIncludePath(self, str path)
    cpdef void definePreProcSym(self, str sym, str value)
    cpdef void undefPreProcSym(self, str sym)
    cpdef int addSrcFile(self, str path)
    cpdef int addSrcStr(self, str src)
    cpdef int addSymbol(self, str sym, val)
    cpdef int relocate(self)
    cpdef getSymbol(self, str sym)

    @staticmethod
    cdef JitCC mk(decl.IJitCC *hndl, bool owned=*)

cdef class Factory(object):
    cdef decl.IFactory             *_hndl

    cpdef init(self, dm_core.DebugMgr dmgr)

    cpdef JitCC mkTinyCC(self)
