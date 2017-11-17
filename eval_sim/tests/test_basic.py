from evaluation_tools.Evaluator import evaluate_file, init

import unittest

class MyTest(unittest.TestCase):
    def testNoError(self):
        noc_rg = init()
        filename = "resources/noerror.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous or results[0].flitfault or results[0].unexpected_len_sent or results[0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid,0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].len_recv, 744)
        self.assertEqual(results[0].len_sent, 744)
        self.assertTrue(results[0].is_valid())

    def testMisrouted(self):
        '''
        A packet routed to a wrong output
        :return:
        '''
        noc_rg = init()
        filename = "resources/misrouted.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertFalse(results[0].flitfault or results[0].unexpected_len_sent or results[0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid,0)
        self.assertEqual(results[0].sents_invalid, 1)
        self.assertEqual(results[0].len_recv, 744)
        self.assertEqual(results[0].len_sent, 744)
        self.assertFalse(results[0].is_valid())

    def testTooMuchSent(self):
        '''
        packets sent multiple times
        :return:
        '''
        noc_rg = init()
        filename = "resources/toomuchsent.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertTrue(results[0].flitfault )
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid,0)
        self.assertEqual(results[0].sents_invalid, 1)
        self.assertEqual(results[0].len_recv, 745)
        self.assertEqual(results[0].len_sent, 745)
        self.assertFalse(results[0].is_valid())

    def testReplacedFlit(self):
        '''
        A packet replaced an other packet, so one missing, one duplicated
        :return:
        '''
        noc_rg = init()
        filename = "resources/replaced_flit.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertTrue(results[0].flitfault)
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid,0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].len_recv, 744)
        self.assertEqual(results[0].len_sent, 744)
        self.assertFalse(results[0].is_valid())

    def testChangedFlitType(self):
        '''
        Changed the Flittype of a received flit from body to tail, so afterwards there will be body flits
        :return:
        '''
        noc_rg = init()
        filename = "resources/changedflittype.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertFalse(results[0].is_valid())
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertTrue(results[0].flitfault)
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid,0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].len_recv, 744)
        self.assertEqual(results[0].len_sent, 744)


if __name__ == '__main__':
    unittest.main()