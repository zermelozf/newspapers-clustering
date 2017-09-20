import unittest
from bias import Bias

class TestBias(unittest.TestCase):

    def test_bias(self):
        self.assertEqual(Bias.get_bias_for_domain(
            'dailykos.com'), Bias.LEFT)
        self.assertEqual(Bias.get_bias_for_domain('theblaze.com'), Bias.RIGHT)


if __name__ == '__main__':
    unittest.main()
