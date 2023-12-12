""""Pytest configuration file."""
import logging
from logging import Logger

logger: Logger = logging.getLogger(__name__)

try:
    import pydevd_pycharm2

    pydevd_pycharm2.settrace(
        "192.168.100.152",
        port=12000,
        stdoutToServer=True,
        stderrToServer=True,
    )
except ImportError as e:
    logger.warning("Error importing pydevd_pycharm %s", str(e))
except ConnectionRefusedError:
    logger.error("Debugger disabled")

