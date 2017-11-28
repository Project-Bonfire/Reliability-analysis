from evaluation_tools.Evaluator import evaluate_file, init,Result

import unittest

class MyTest(unittest.TestCase):
    def testNoError(self):
        noc_rg = init()
        filename = "resources/noerror.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous or results[0].connection_counter_invalid or results[0].unexpected_len_sent or results[0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid,0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].misrouted_recv, 0)
        self.assertEqual(results[0].misrouted_sent, 0)
        self.assertEqual(results[0].len_recv, 509)
        self.assertEqual(results[0].len_sent, 509)
        self.assertTrue(results[0].is_valid())

    def testMisrouted(self):
        '''
        A flit routed to a wrong output
        :return:
        '''
        noc_rg = init()
        filename = "resources/CorrectDelivery/misrouted.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertFalse(results[0].connection_counter_invalid or results[0].unexpected_len_sent or results[0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid,1)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].len_recv, 509)
        self.assertEqual(results[0].len_sent, 509)
        self.assertFalse(results[0].is_valid())

    def testMisrouted2(self):
        '''
        A whole packet routed to the wrong output

        :return:
        '''
        noc_rg = init()
        filename = "resources/CorrectDelivery/misrouted2.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertFalse(results[0].is_valid())
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid,8)
        self.assertEqual(results[0].sents_invalid, 0)

    def testMisrouted3(self):
        '''
        A whole packet routed to the wrong output
        Packet was routed back to its origin
        :return:
        '''
        noc_rg = init()
        filename = "resources/CorrectDelivery/misrouted3.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertFalse(results[0].is_valid())
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid,8)
        self.assertEqual(results[0].sents_invalid, 0)

    def testTooMuchSent(self):
        '''
        bodz flits sent multiple times
        :return:
        '''
        noc_rg = init()
        filename = "resources/ReliableDelivery/toomuchsent.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertTrue(results[0].connection_counter_invalid )
        self.assertTrue(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid,0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].len_recv, 510)
        self.assertEqual(results[0].len_sent, 509)
        self.assertFalse(results[0].is_valid())

    def testTooMuchSent2(self):
        '''
        packet sent multiple times
        :return:
        '''
        noc_rg = init()
        filename = "resources/ReliableDelivery/toomuchsent2.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertTrue(results[0].connection_counter_invalid )
        self.assertTrue(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid,0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].len_recv, 517)
        self.assertEqual(results[0].len_sent, 509)
        self.assertFalse(results[0].is_valid())

    def testFlitsMissing(self):
        '''
        Missing flits in the recv part
        :return:
        '''
        noc_rg = init()
        filename = "resources/ReliableDelivery/flitsmissing.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertTrue(results[0].connection_counter_invalid )
        self.assertTrue(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid,0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].len_recv, 739)
        self.assertEqual(results[0].len_sent, 509)
        self.assertFalse(results[0].is_valid())

    def testDestinationChanged(self):
        '''
        Changed the destination of a packet
        :return:
        '''
        noc_rg = init()
        filename = "resources/FlitIntegrity/destinationchanged.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertTrue(results[0].connection_counter_invalid )
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid,0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].len_recv, 509)
        self.assertEqual(results[0].len_sent, 509)
        self.assertFalse(results[0].is_valid())

    def testDestinationChanged2(self):
        '''
        Changed the destination of a packet. This actually only results in a misrouting.
        :return:
        '''
        noc_rg = init()
        filename = "resources/CorrectDelivery/destinationchanged2.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertFalse(results[0].connection_counter_invalid )
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid,16)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].len_recv, 509)
        self.assertEqual(results[0].len_sent, 509)
        self.assertFalse(results[0].is_valid())

    def testDestinationChanged3(self):
        '''
        Changed the destination of a packet. Also fixed currentnode, so it is not misrouted.
        :return:
        '''
        noc_rg = init()
        filename = "resources/FlitIntegrity/destinationchanged3.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertFalse(results[0].connection_counter_invalid )
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid,0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].len_recv, 509)
        self.assertEqual(results[0].len_sent, 509)
        self.assertFalse(results[0].is_valid())

    def testPacketIntegrity1(self):
        '''
        Swapped the length of 2 packets on the same connection. One is now too long, one is too short. The differences cancel each other out.
        :return:
        '''
        noc_rg = init()
        filename = "resources/PacketIntegrity/packetlength.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertFalse(results[0].connection_counter_invalid )
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid,0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].len_recv, 743)
        self.assertEqual(results[0].len_sent, 743)
        self.assertFalse(results[0].is_valid())

    def testReplacedFlit(self):
        '''
        A flit replaced an other flit, so one missing, one duplicated
        :return:
        '''
        noc_rg = init()
        filename = "resources/replaced_flit.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertFalse(results[0].connection_counter_invalid)
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid,2)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].len_recv, 509)
        self.assertEqual(results[0].len_sent, 509)
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


if __name__ == '__main__':
    unittest.main()