cimport debug_mgr.decl as dm_decl
from libcpp.pair cimport pair as cpp_pair
from libcpp.set cimport set as cpp_set
from libcpp.string cimport string as cpp_string
from libcpp.vector cimport vector as cpp_vector
from libcpp.memory cimport unique_ptr
from libc.stdint cimport intptr_t
from libc.stdint cimport uintptr_t
from libc.stdint cimport int32_t
from libc.stdint cimport uint32_t
from libc.stdint cimport uint64_t
from libc.stdint cimport int64_t
from libcpp cimport bool
cimport cpython.ref as cpy_ref

ctypedef IFactory *IFactoryP

cdef extern from "jit/cc/IJitCC.h" namespace "jit::cc":
    cdef cppclass IJitCC:
        int addIncludePath(const cpp_string &path)
        int addSysIncludePath(const cpp_string &path)
        void definePreProcSym(const cpp_string &sym, const cpp_string &value)
        void undefPreProcSym(const cpp_string &sym)
        int addSrcFile(const cpp_string &path)
        int addSrcStr(const cpp_string &src)
        int addSymbol(const cpp_string &sym, void *val)
        int relocate()
        void *getSymbol(const cpp_string &sym)

cdef extern from "jit/cc/IFactory.h" namespace "jit::cc":
    cdef cppclass IFactory:
        void init(dm_decl.IDebugMgr *dmgr)
        IJitCC *mkTinyCC()