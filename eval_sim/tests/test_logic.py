from evaluation_tools.Evaluator import evaluate_file, init, Result, Module

import unittest


class MyTest(unittest.TestCase):
    def testGetModules(self):#7325 1675 0 10 \FIFO_W/FIFO_comb/U208 :A2 FIFO_W/FIFO_comb/n384 [('FIFO_W/FIFO_comb/U209/Q', 'Output Pin(INVXL)')]
        res = Result()
        res.params = '8173 2827 0 10 \FIFO_L/FIFO_comb/U116 :B2 !fifo'
        self.assertEqual(res.getFaultModuleFromParam(),Module.fifo)
    def testGetModulesOld(self):#
        res = Result()
        res.params = "7325 1675 0 10 \FIFO_W/FIFO_comb/U208 :A2 FIFO_W/FIFO_comb/n384 [('FIFO_W/FIFO_comb/U209/Q', 'Output Pin(INVXL)')]"
        self.assertEqual(res.getFaultModuleFromParam(),Module.fifo)

