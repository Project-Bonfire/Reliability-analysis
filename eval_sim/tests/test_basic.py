from evaluation_tools.Evaluator import evaluate_file, init, Result, Faulttype

import unittest


class MyTest(unittest.TestCase):
    def testNoError(self):
        noc_rg = init()
        filename = "tests/resources/noerror.results"
        module_dict = {
            'xbar': 'b825ea8fa845a73e9dcb22beefb5acec75103e95',
            'arbiter': '134771791c89f5bbd306e5156023e1e19409b73f',
            'lbdr': '8ca292256f6e056fe592ee5fcfa84b9e39e5c8bb',
            'fifo': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifod': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifoc': '1209a2e8847e82d48828b5e5fe336d19de9d2816'
        }
        errornous, results = evaluate_file(noc_rg, filename, module_reference=module_dict,print_verbose=True)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        res:Result = results[0]
        self.assertFalse(
            results[0].errornous or results[0].connection_counter_invalid or results[0].unexpected_len_sent or results[
                0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid, 0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].misrouted_recv, 0)
        self.assertEqual(results[0].misrouted_sent, 0)
        self.assertEqual(results[0].len_recv, 509)
        self.assertEqual(results[0].len_sent, 509)
        self.assertTrue(results[0].is_valid())
        self.assertTrue(res.vcd_of_module_equal['xbar'])
        self.assertTrue(res.vcd_of_module_equal['arbiter'])
        self.assertTrue(res.vcd_of_module_equal['lbdr'])
        self.assertTrue(res.vcd_of_module_equal['fifo'])
        self.assertTrue(res.vcd_of_module_equal['fifod'])
        self.assertTrue(res.vcd_of_module_equal['fifoc'])
        self.assertEqual(res.guessComponent(),'nofault')

    def testNoError3(self):
        noc_rg = init()
        filename = "tests/resources/3flittests/noerror3.results"
        module_dict = {
            'xbar': 'b825ea8fa845a73e9dcb22beefb5acec75103e95',
            'arbiter': '134771791c89f5bbd306e5156023e1e19409b73f',
            'lbdr': '8ca292256f6e056fe592ee5fcfa84b9e39e5c8bb',
            'fifo': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifod': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifoc': '1209a2e8847e82d48828b5e5fe336d19de9d2816'
        }
        errornous, results = evaluate_file(noc_rg, filename, module_reference=module_dict, print_verbose=True)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        res: Result = results[0]
        self.assertFalse(
            results[0].errornous or results[0].connection_counter_invalid or results[0].unexpected_len_sent or results[
                0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid, 0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].misrouted_recv, 0)
        self.assertEqual(results[0].misrouted_sent, 0)
        self.assertEqual(results[0].len_recv, 3)
        self.assertEqual(results[0].len_sent, 3)
        self.assertTrue(results[0].is_valid())
        self.assertTrue(res.vcd_of_module_equal['xbar'])
        self.assertTrue(res.vcd_of_module_equal['arbiter'])
        self.assertTrue(res.vcd_of_module_equal['lbdr'])
        self.assertTrue(res.vcd_of_module_equal['fifo'])
        self.assertTrue(res.vcd_of_module_equal['fifod'])
        self.assertTrue(res.vcd_of_module_equal['fifoc'])
        self.assertEqual(res.guessComponent(), 'nofault')
        self.assertFalse(res.hasError(Faulttype.INVALIDFLITS))
        self.assertFalse(res.hasError(Faulttype.MISROUTED))
        self.assertFalse(res.hasError(Faulttype.FAILEDDELIVERY))

    def testNoError4(self):
        """
        test 4 flits
        :return:
        """
        noc_rg = init()
        filename = "tests/resources/3flittests/4flit.results"
        module_dict = {
            'xbar': 'b825ea8fa845a73e9dcb22beefb5acec75103e95',
            'arbiter': '134771791c89f5bbd306e5156023e1e19409b73f',
            'lbdr': '8ca292256f6e056fe592ee5fcfa84b9e39e5c8bb',
            'fifo': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifod': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifoc': '1209a2e8847e82d48828b5e5fe336d19de9d2816'
        }
        errornous, results = evaluate_file(noc_rg, filename, module_reference=module_dict, print_verbose=True)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        res: Result = results[0]
        self.assertFalse(
            results[0].errornous or results[0].connection_counter_invalid or results[0].unexpected_len_sent or results[
                0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid, 0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].misrouted_recv, 0)
        self.assertEqual(results[0].misrouted_sent, 0)
        self.assertEqual(results[0].len_recv, 4)
        self.assertEqual(results[0].len_sent, 4)
        self.assertTrue(results[0].is_valid())
        self.assertTrue(res.vcd_of_module_equal['xbar'])
        self.assertTrue(res.vcd_of_module_equal['arbiter'])
        self.assertTrue(res.vcd_of_module_equal['lbdr'])
        self.assertTrue(res.vcd_of_module_equal['fifo'])
        self.assertTrue(res.vcd_of_module_equal['fifod'])
        self.assertTrue(res.vcd_of_module_equal['fifoc'])
        self.assertEqual(res.guessComponent(), 'nofault')
        self.assertFalse(res.hasError(Faulttype.INVALIDFLITS))
        self.assertFalse(res.hasError(Faulttype.MISROUTED))
        self.assertFalse(res.hasError(Faulttype.FAILEDDELIVERY))

    def test4flitmisr1(self):
        """
        make a 4flit packet to a 3 flit by misrouting
        :return:
        """
        noc_rg = init()
        filename = "tests/resources/3flittests/4flitmisrouted1.results"
        module_dict = {
            'xbar': 'b825ea8fa845a73e9dcb22beefb5acec75103e95',
            'arbiter': '134771791c89f5bbd306e5156023e1e19409b73f',
            'lbdr': '8ca292256f6e056fe592ee5fcfa84b9e39e5c8bb',
            'fifo': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifod': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifoc': '1209a2e8847e82d48828b5e5fe336d19de9d2816'
        }
        errornous, results = evaluate_file(noc_rg, filename, module_reference=module_dict, print_verbose=True)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        res: Result = results[0]
        self.assertFalse(
            results[0].errornous or results[0].connection_counter_invalid or results[0].unexpected_len_sent or results[
                0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid, 2)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].misrouted_recv, 1)
        self.assertEqual(results[0].misrouted_sent, 0)
        self.assertEqual(results[0].len_recv, 4)
        self.assertEqual(results[0].len_sent, 4)
        self.assertFalse(results[0].is_valid())
        self.assertTrue(res.vcd_of_module_equal['xbar'])
        self.assertTrue(res.vcd_of_module_equal['arbiter'])
        self.assertTrue(res.vcd_of_module_equal['lbdr'])
        self.assertTrue(res.vcd_of_module_equal['fifo'])
        self.assertTrue(res.vcd_of_module_equal['fifod'])
        self.assertTrue(res.vcd_of_module_equal['fifoc'])
        self.assertEqual(res.guessComponent(), 'nofault')
        self.assertTrue(res.hasError(Faulttype.INVALIDFLITS))
        self.assertTrue(res.hasError(Faulttype.MISROUTED))
        self.assertFalse(res.hasError(Faulttype.FAILEDDELIVERY))

    def test4flitdropped1(self):
        """
        make a 4 flit packet to a 3 flit packet by dropping the body
        :return:
        """
        noc_rg = init()
        filename = "tests/resources/3flittests/4flitdropped1.results"
        module_dict = {
            'xbar': 'b825ea8fa845a73e9dcb22beefb5acec75103e95',
            'arbiter': '134771791c89f5bbd306e5156023e1e19409b73f',
            'lbdr': '8ca292256f6e056fe592ee5fcfa84b9e39e5c8bb',
            'fifo': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifod': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifoc': '1209a2e8847e82d48828b5e5fe336d19de9d2816'
        }
        errornous, results = evaluate_file(noc_rg, filename, module_reference=module_dict, print_verbose=True)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        res: Result = results[0]
        self.assertEqual(results[0].recv_invalid, 0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].misrouted_recv, 0)
        self.assertEqual(results[0].misrouted_sent, 0)
        self.assertEqual(results[0].len_recv, 3)
        self.assertEqual(results[0].len_sent, 4)
        self.assertFalse(results[0].is_valid())
        self.assertTrue(res.vcd_of_module_equal['xbar'])
        self.assertTrue(res.vcd_of_module_equal['arbiter'])
        self.assertTrue(res.vcd_of_module_equal['lbdr'])
        self.assertTrue(res.vcd_of_module_equal['fifo'])
        self.assertTrue(res.vcd_of_module_equal['fifod'])
        self.assertTrue(res.vcd_of_module_equal['fifoc'])
        self.assertEqual(res.guessComponent(), 'nofault')
        self.assertFalse(res.hasError(Faulttype.INVALIDFLITS))
        self.assertFalse(res.hasError(Faulttype.MISROUTED))
        self.assertTrue(res.hasError(Faulttype.FAILEDDELIVERY))

    def test3flitdropped1(self):
        """
        test dropped B1 flit
        :return:
        """
        noc_rg = init()
        filename = "tests/resources/3flittests/droppedB1.results"
        module_dict = {
            'xbar': 'b825ea8fa845a73e9dcb22beefb5acec75103e95',
            'arbiter': '134771791c89f5bbd306e5156023e1e19409b73f',
            'lbdr': '8ca292256f6e056fe592ee5fcfa84b9e39e5c8bb',
            'fifo': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifod': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifoc': '1209a2e8847e82d48828b5e5fe336d19de9d2816'
        }
        errornous, results = evaluate_file(noc_rg, filename, module_reference=module_dict, print_verbose=True)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        res: Result = results[0]
        self.assertEqual(results[0].recv_invalid, 1)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].misrouted_recv, 0)
        self.assertEqual(results[0].misrouted_sent, 0)
        self.assertEqual(results[0].len_recv, 2)
        self.assertEqual(results[0].len_sent, 3)
        self.assertFalse(results[0].is_valid())
        self.assertTrue(res.vcd_of_module_equal['xbar'])
        self.assertTrue(res.vcd_of_module_equal['arbiter'])
        self.assertTrue(res.vcd_of_module_equal['lbdr'])
        self.assertTrue(res.vcd_of_module_equal['fifo'])
        self.assertTrue(res.vcd_of_module_equal['fifod'])
        self.assertTrue(res.vcd_of_module_equal['fifoc'])
        self.assertEqual(res.guessComponent(), 'nofault')
        self.assertTrue(res.hasError(Faulttype.INVALIDFLITS))
        self.assertFalse(res.hasError(Faulttype.MISROUTED))
        self.assertTrue(res.hasError(Faulttype.FAILEDDELIVERY))

    def test3flitchangedtail(self):
        noc_rg = init()
        filename = "tests/resources/3flittests/changedtail.results"
        module_dict = {
            'xbar': 'b825ea8fa845a73e9dcb22beefb5acec75103e95',
            'arbiter': '134771791c89f5bbd306e5156023e1e19409b73f',
            'lbdr': '8ca292256f6e056fe592ee5fcfa84b9e39e5c8bb',
            'fifo': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifod': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifoc': '1209a2e8847e82d48828b5e5fe336d19de9d2816'
        }
        errornous, results = evaluate_file(noc_rg, filename, module_reference=module_dict, print_verbose=True)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        res: Result = results[0]
        self.assertFalse(
            results[0].errornous or results[0].connection_counter_invalid or results[0].unexpected_len_sent or results[
                0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid, 1)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].misrouted_recv, 0)
        self.assertEqual(results[0].misrouted_sent, 0)
        self.assertEqual(results[0].len_recv, 3)
        self.assertEqual(results[0].len_sent, 3)
        self.assertFalse(results[0].is_valid())
        self.assertTrue(res.vcd_of_module_equal['xbar'])
        self.assertTrue(res.vcd_of_module_equal['arbiter'])
        self.assertTrue(res.vcd_of_module_equal['lbdr'])
        self.assertTrue(res.vcd_of_module_equal['fifo'])
        self.assertTrue(res.vcd_of_module_equal['fifod'])
        self.assertTrue(res.vcd_of_module_equal['fifoc'])
        self.assertEqual(res.guessComponent(), 'nofault')
        self.assertTrue(res.hasError(Faulttype.INVALIDFLITS))
        self.assertFalse(res.hasError(Faulttype.MISROUTED))
        self.assertFalse(res.hasError(Faulttype.FAILEDDELIVERY))

    def testMisrouted3flits(self):
        """
        test if a misrouted flit causes invalid and misrouted
        3 misrouted, all fsms valid, all flits correct

        """
        noc_rg = init()
        filename = "tests/resources/3flittests/misrouted.results"
        module_dict = {
            'xbar': 'b825ea8fa845a73e9dcb22beefb5acec75103e95',
            'arbiter': '134771791c89f5bbd306e5156023e1e19409b73f',
            'lbdr': '8ca292256f6e056fe592ee5fcfa84b9e39e5c8bb',
            'fifo': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifod': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifoc': '1209a2e8847e82d48828b5e5fe336d19de9d2816'
        }
        errornous, results = evaluate_file(noc_rg, filename, module_reference=module_dict, print_verbose=True)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        res: Result = results[0]
        self.assertFalse(
            results[0].errornous or results[0].connection_counter_invalid or results[0].unexpected_len_sent or results[
                0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid, 0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].misrouted_recv, 3)
        self.assertEqual(results[0].misrouted_sent, 0)
        self.assertEqual(results[0].len_recv, 3)
        self.assertEqual(results[0].len_sent, 3)
        self.assertFalse(results[0].is_valid())
        self.assertTrue(res.vcd_of_module_equal['xbar'])
        self.assertTrue(res.vcd_of_module_equal['arbiter'])
        self.assertTrue(res.vcd_of_module_equal['lbdr'])
        self.assertTrue(res.vcd_of_module_equal['fifo'])
        self.assertTrue(res.vcd_of_module_equal['fifod'])
        self.assertTrue(res.vcd_of_module_equal['fifoc'])
        self.assertEqual(res.guessComponent(), 'nofault')
        self.assertFalse(res.hasError(Faulttype.INVALIDFLITS))
        self.assertTrue(res.hasError(Faulttype.MISROUTED))
        self.assertFalse(res.hasError(Faulttype.FAILEDDELIVERY))

    def testMisrouted3flits2(self):
        """
        test if a misrouted flit causes invalid and misrouted
        2 flits misrouterd, 2 times invalid, because 2 fsms were violated
        :return:
        """
        noc_rg = init()
        filename = "tests/resources/3flittests/misrouted2.results"
        module_dict = {
            'xbar': 'b825ea8fa845a73e9dcb22beefb5acec75103e95',
            'arbiter': '134771791c89f5bbd306e5156023e1e19409b73f',
            'lbdr': '8ca292256f6e056fe592ee5fcfa84b9e39e5c8bb',
            'fifo': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifod': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifoc': '1209a2e8847e82d48828b5e5fe336d19de9d2816'
        }
        errornous, results = evaluate_file(noc_rg, filename, module_reference=module_dict, print_verbose=True)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        res: Result = results[0]
        self.assertFalse(
            results[0].errornous or results[0].connection_counter_invalid or results[0].unexpected_len_sent or results[
                0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid, 2)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].misrouted_recv, 2)
        self.assertEqual(results[0].misrouted_sent, 0)
        self.assertEqual(results[0].len_recv, 3)
        self.assertEqual(results[0].len_sent, 3)
        self.assertFalse(results[0].is_valid())
        self.assertTrue(res.vcd_of_module_equal['xbar'])
        self.assertTrue(res.vcd_of_module_equal['arbiter'])
        self.assertTrue(res.vcd_of_module_equal['lbdr'])
        self.assertTrue(res.vcd_of_module_equal['fifo'])
        self.assertTrue(res.vcd_of_module_equal['fifod'])
        self.assertTrue(res.vcd_of_module_equal['fifoc'])
        self.assertTrue(res.hasError(Faulttype.INVALIDFLITS))
        self.assertTrue(res.hasError(Faulttype.MISROUTED))
        self.assertFalse(res.hasError(Faulttype.FAILEDDELIVERY))
        self.assertEqual(res.guessComponent(), 'nofault')

    def testMisrouted3flits3(self):
        """
        test if a misrouted flit causes invalid and misrouted
        1 flit misrouted 2 fsms violated
        """
        noc_rg = init()
        filename = "tests/resources/3flittests/misrouted3.results"
        module_dict = {
            'xbar': 'b825ea8fa845a73e9dcb22beefb5acec75103e95',
            'arbiter': '134771791c89f5bbd306e5156023e1e19409b73f',
            'lbdr': '8ca292256f6e056fe592ee5fcfa84b9e39e5c8bb',
            'fifo': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifod': '1209a2e8847e82d48828b5e5fe336d19de9d2816',
            'fifoc': '1209a2e8847e82d48828b5e5fe336d19de9d2816'
        }
        errornous, results = evaluate_file(noc_rg, filename, module_reference=module_dict, print_verbose=True)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        res: Result = results[0]
        self.assertFalse(
            results[0].errornous or results[0].connection_counter_invalid or results[0].unexpected_len_sent or results[
                0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid, 2)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].misrouted_recv, 1)
        self.assertEqual(results[0].misrouted_sent, 0)
        self.assertEqual(results[0].len_recv, 3)
        self.assertEqual(results[0].len_sent, 3)
        self.assertFalse(results[0].is_valid())
        self.assertTrue(res.vcd_of_module_equal['xbar'])
        self.assertTrue(res.vcd_of_module_equal['arbiter'])
        self.assertTrue(res.vcd_of_module_equal['lbdr'])
        self.assertTrue(res.vcd_of_module_equal['fifo'])
        self.assertTrue(res.vcd_of_module_equal['fifod'])
        self.assertTrue(res.vcd_of_module_equal['fifoc'])
        self.assertEqual(res.guessComponent(), 'nofault')
        self.assertTrue(res.hasError(Faulttype.INVALIDFLITS))
        self.assertTrue(res.hasError(Faulttype.MISROUTED))
        self.assertFalse(res.hasError(Faulttype.FAILEDDELIVERY))

    def testFifoHashesSeperated(self):
        noc_rg = init()
        filename = "tests/resources/fifo_hashes_seperated.results"
        module_dict = {
            'xbar': '178e187dbfd6824f350aa98339998107a31d2382',
            'arbiter': '6845bd7aa42376d81ea1839cd1476f006f9412ca',
            'lbdr': '06d449e2fc9a95df0719ef26a802a5c7947ff6bc',
            'fifo': '9c4b2ee0622fb8cfb8d4b24c554da1c21688cfa5',
            'fifoc':'0b1c5bae9152c6dfbfec730e12bdf2641e8684ee',
            'fifod':'fc7f0c5dc1980d2abd8e4a68d19096af0aacf71f'
        }
        errornous, results = evaluate_file(noc_rg, filename, module_reference=module_dict,print_verbose=True)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        res:Result = results[0]
        self.assertFalse(
            results[0].errornous or results[0].connection_counter_invalid or results[0].unexpected_len_sent or results[
                0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid, 0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].misrouted_recv, 0)
        self.assertEqual(results[0].misrouted_sent, 0)
        self.assertEqual(results[0].len_recv, 509)
        self.assertEqual(results[0].len_sent, 509)
        self.assertTrue(results[0].is_valid())
        self.assertTrue(res.vcd_of_module_equal['xbar'])
        self.assertTrue(res.vcd_of_module_equal['arbiter'])
        self.assertTrue(res.vcd_of_module_equal['lbdr'])
        self.assertTrue(res.vcd_of_module_equal['fifo'])
        self.assertEqual(res.guessComponent(),'nofault')

    def testOnlyHashError(self):
        noc_rg = init()
        filename = "tests/resources/noerror.results"
        module_dict = {
            'xbar': 'peninsula',
            'arbiter': '134771791c89f5bbd306e5156023e1e19409b73f',
            'lbdr': '8ca292256f6e056fe592ee5fcfa84b9e39e5c8bb',
            'fifo': '1209a2e8847e82d48828b5e5fe336d19de9d2816'
        }
        errornous, results = evaluate_file(noc_rg, filename, module_reference=module_dict,print_verbose=True)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        res:Result = results[0]
        self.assertFalse(
            results[0].errornous or results[0].connection_counter_invalid or results[0].unexpected_len_sent or results[
                0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid, 0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].misrouted_recv, 0)
        self.assertEqual(results[0].misrouted_sent, 0)
        self.assertEqual(results[0].len_recv, 509)
        self.assertEqual(results[0].len_sent, 509)
        self.assertTrue(results[0].is_valid())
        self.assertFalse(res.vcd_of_module_equal['xbar'])
        self.assertTrue(res.vcd_of_module_equal['arbiter'])
        self.assertTrue(res.vcd_of_module_equal['lbdr'])
        self.assertTrue(res.vcd_of_module_equal['fifo'])


    def testMisrouted(self):
        '''
        A flit routed to a wrong output
        :return:
        '''
        noc_rg = init()
        filename = "tests/resources/CorrectDelivery/misrouted.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertFalse(
            results[0].connection_counter_invalid or results[0].unexpected_len_sent or results[0].unexpected_len_recv)
        self.assertEqual(results[0].recv_invalid, 2)
        self.assertEqual(results[0].misrouted_recv, 1)
        self.assertEqual(results[0].misrouted_sent, 0)
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
        filename = "tests/resources/CorrectDelivery/misrouted2.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertFalse(results[0].is_valid())
        self.assertEqual(results[0].misrouted_recv, 8)
        self.assertEqual(results[0].misrouted_sent, 0)
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid, 0)
        self.assertEqual(results[0].sents_invalid, 0)

    def testMisrouted3(self):
        '''
        A whole packet routed to the wrong output
        Packet was routed back to its origin
        :return:
        '''
        noc_rg = init()
        filename = "tests/resources/CorrectDelivery/misrouted3.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertFalse(results[0].is_valid())
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid, 0)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].misrouted_recv, 8)
        self.assertEqual(results[0].misrouted_sent, 0)

    def testTooMuchSent(self):
        '''
        bodz flits sent multiple times
        :return:
        '''
        noc_rg = init()
        filename = "tests/resources/ReliableDelivery/toomuchsent.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertTrue(results[0].connection_counter_invalid)
        self.assertEqual(results[0].recv_invalid, 0)
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
        filename = "tests/resources/ReliableDelivery/toomuchsent2.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertTrue(results[0].connection_counter_invalid)
        self.assertEqual(results[0].recv_invalid, 0)
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
        filename = "tests/resources/ReliableDelivery/flitsmissing.results"
        errornous, results = evaluate_file(noc_rg, filename,expected_len_recv=509,expected_len_sent=509)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertTrue(results[0].connection_counter_invalid)
        self.assertEqual(results[0].len_recv, 508)
        self.assertEqual(results[0].len_sent, 509)
        self.assertTrue(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid, 0)
        self.assertEqual(results[0].sents_invalid, 0)

        self.assertFalse(results[0].is_valid())

    def testDestinationChanged(self):
        '''
        Changed the destination of a packet
        :return:
        '''
        noc_rg = init()
        filename = "tests/resources/FlitIntegrity/destinationchanged.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertTrue(results[0].connection_counter_invalid)
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid, 6)
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
        filename = "tests/resources/CorrectDelivery/destinationchanged2.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertFalse(results[0].connection_counter_invalid)
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid, 0)
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
        filename = "tests/resources/FlitIntegrity/destinationchanged3.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertTrue(results[0].connection_counter_invalid)
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid, 6)
        self.assertEqual(results[0].sents_invalid, 0)
        self.assertEqual(results[0].len_recv, 509)
        self.assertEqual(results[0].len_sent, 509)
        self.assertFalse(results[0].is_valid())


    def testReplacedFlit(self):
        '''
        A flit replaced an other flit, so one missing, one duplicated
        :return:
        '''
        noc_rg = init()
        filename = "tests/resources/replaced_flit.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)
        self.assertFalse(results[0].connection_counter_invalid)
        self.assertFalse(results[0].unexpected_len_recv)
        self.assertFalse(results[0].unexpected_len_sent)
        self.assertEqual(results[0].recv_invalid, 2)
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
        filename = "tests/resources/changedflittype.results"
        errornous, results = evaluate_file(noc_rg, filename)
        self.assertFalse(results[0].is_valid())
        self.assertEqual(len(errornous), 0)
        self.assertEqual(len(results), 1)
        self.assertFalse(results[0].errornous)


if __name__ == '__main__':
    unittest.main()
