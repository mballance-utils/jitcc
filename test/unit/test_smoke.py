
from .test_base import TestBase
import jitcc.core as jitcc

class TestSmoke(TestBase):

    def test_smoke(self):
        factory = jitcc.Factory.inst()
        cc = factory.mkTinyCC()

