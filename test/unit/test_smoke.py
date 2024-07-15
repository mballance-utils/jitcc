
import ctypes
from .test_base import TestBase
import jitcc.core as jitcc

class TestSmoke(TestBase):

    def test_smoke(self):
        factory = jitcc.Factory.inst()
        cc = factory.mkTinyCC()

        def bar(a):
            print("Bar: %d" % a)

        bar_t = ctypes.CFUNCTYPE(None, ctypes.c_int)
        bar_cb = bar_t(bar)

        cc.addSrcStr("""
            #include <stdio.h>
            int a;
            void bar(int a);

            void foo(int v) { 
                     fprintf(stdout, \"Hello: %p\\n\", &bar);
                     fflush(stdout);
                bar(v+10);
            }
        """)

        cc.addSymbol("bar", bar_cb)
        cc.relocate()

        foo_t = ctypes.CFUNCTYPE(None, ctypes.c_int)

        foo_p = cc.getSymbol("foo")
        foo = foo_t(foo_p.value)
        print("foo_p: %s" % str(foo_p))

        foo(20)


