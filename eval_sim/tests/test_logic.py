from evaluation_tools.Evaluator import evaluate_file, init, Result

import unittest


class MyTest(unittest.TestCase):
    def testGetModules(self):
        res = Result()
        res.params = '8173 2827 0 10 \FIFO_L/FIFO_comb/U116 :B2 !fifoc'
        self.assertEqual(res.getFaultModuleFromParam(),'fifoc')

    def testGetModulesNone(self):
        res = Result()
        res.params = '8173 2827 0 10 \FIFO_L/FIFO_comb/U116 :B2 !none'
        self.assertEqual(res.getFaultModuleFromParam(),'none')

    def testGetModulesNofault(self): #1770 9230 0 10 nofault :nofault
        res = Result()
        res.params = '8173 2827 0 10 \FIFO_L/FIFO_comb/U116 :B2 !nofault'
        self.assertEqual(res.getFaultModuleFromParam(),'nofault')
