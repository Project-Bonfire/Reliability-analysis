
import unittest
from frame_based import xyrouting


class TestRouting(unittest.TestCase):
    def setUp(self):
        pass

    def test_xyrouting(self):
        self.assertEqual(xyrouting(1,5,4),[5,9,13])
        self.assertEqual(xyrouting(9, 5, 4), [1, 5])
        self.assertEqual(sorted(xyrouting(6, 5, 4)), sorted([0,1,5,4,9,8,12,13]))
        self.assertEqual(sorted(xyrouting(4, 5, 4)), sorted(list(set(range(16))-{0,4,8,12})))
        self.assertEqual(sorted(xyrouting(5, 5, 4)), sorted(list(set(range(16)) - {5})))

if __name__ == '__main__':
    unittest.main()