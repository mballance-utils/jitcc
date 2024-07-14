import os
import sys
import unittest

unit_dir = os.path.dirname(os.path.abspath(__file__))
proj_dir = os.path.dirname(os.path.dirname(unit_dir))
sys.path.insert(0, os.path.join(proj_dir, "python"))

class TestBase(unittest.TestCase):
    pass
