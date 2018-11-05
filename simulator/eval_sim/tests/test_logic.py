from evaluation_tools.Evaluator import evaluate_file, init, Result, FlitEvent, evaluate_flit_fsm

import unittest


class Dummy():
    """
    0 -> Head 1-> Body1 ...
    """
    type = None
    currentrouter = 0

    def __init__(self, type):
        self.type = [FlitEvent.Type.HEAD, FlitEvent.Type.BODY1, FlitEvent.Type.BODY, FlitEvent.Type.TAIL][type]

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



    def testFlitFSM(self):
        t=[FlitEvent.Type.HEAD, FlitEvent.Type.BODY1, FlitEvent.Type.BODY, FlitEvent.Type.TAIL]
        node_states = {i: FlitEvent.Type.TAIL for i in [0]}
        #HEAD
        node_states = evaluate_flit_fsm(node_states, Dummy(0)  , None, lambda a,b: self.fail())
        self.assertEqual(node_states[0],t[0])
        #BODY1
        node_states = evaluate_flit_fsm(node_states, Dummy(1), None, lambda a, b: self.fail())
        self.assertEqual(node_states[0], t[1])
        #BODY
        node_states = evaluate_flit_fsm(node_states, Dummy(2), None, lambda a, b: self.fail())
        self.assertEqual(node_states[0], t[2])
        #TAIL
        node_states = evaluate_flit_fsm(node_states, Dummy(3), None, lambda a, b: self.fail())
        self.assertEqual(node_states[0], t[3])
        # HEAD
        node_states = evaluate_flit_fsm(node_states, Dummy(0), None, lambda a, b: self.fail())
        self.assertEqual(node_states[0], t[0])
        # BODY1
        node_states = evaluate_flit_fsm(node_states, Dummy(1), None, lambda a, b: self.fail())
        self.assertEqual(node_states[0], t[1])
        # TAIL
        node_states = evaluate_flit_fsm(node_states, Dummy(3), None, lambda a, b: self.fail())
        self.assertEqual(node_states[0], t[3])
        # TAIL
        node_states = evaluate_flit_fsm(node_states, Dummy(3), None, lambda a, b: self.assertTrue(True))
        self.assertEqual(node_states[0], t[3])
        # HEAD
        node_states = evaluate_flit_fsm(node_states, Dummy(0), None, lambda a, b: self.fail())
        self.assertEqual(node_states[0], t[0])
        # HEAD
        node_states = evaluate_flit_fsm(node_states, Dummy(0), None, lambda a, b: self.assertTrue(True))
        self.assertEqual(node_states[0], t[0])
        #BODY
        node_states = evaluate_flit_fsm(node_states, Dummy(2), None, lambda a, b: self.assertTrue(True))
        self.assertEqual(node_states[0], t[2])
        # HEAD
        node_states = evaluate_flit_fsm(node_states, Dummy(0), None, lambda a, b: self.assertTrue(True))
        self.assertEqual(node_states[0], t[0])
        # BODY1
        node_states = evaluate_flit_fsm(node_states, Dummy(1), None, lambda a, b: self.fail())
        self.assertEqual(node_states[0], t[1])
        # TAIL
        node_states = evaluate_flit_fsm(node_states, Dummy(3), None, lambda a, b: self.fail())
        self.assertEqual(node_states[0], t[3])
        # BODY1
        node_states = evaluate_flit_fsm(node_states, Dummy(1), None, lambda a, b: self.assertTrue(True))
        self.assertEqual(node_states[0], t[1])