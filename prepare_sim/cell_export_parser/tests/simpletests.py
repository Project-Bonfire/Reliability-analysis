import unittest

import sys
from io import StringIO

from convert_to_pins import main

class MyTestCase(unittest.TestCase):
    def test_expected(self):
        self.maxDiff= None
        old_stdout = sys.stdout
        sys.stdout = mystdout = StringIO()
        main("test.txt")
        sys.stdout = old_stdout
        cmpdata = ""
        with open('expected_results.txt', 'r') as myfile:
            cmpdata = myfile.read()
        result = mystdout.getvalue()
        self.assertEqual(cmpdata,result)


if __name__ == '__main__':
    unittest.main()
