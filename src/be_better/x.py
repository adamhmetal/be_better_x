"""
Main
"""


def x(a) -> int:
    """
    Docs
    """
    return 1 + a


class X:
    """
    Docs
    """

    def __init__(self):
        pass

    @property
    def x(self) -> int:
        """

        :return:
        """
        return 1

    @staticmethod
    def v() -> int:
        """

        :return:
        """
        return 4


x(1)
