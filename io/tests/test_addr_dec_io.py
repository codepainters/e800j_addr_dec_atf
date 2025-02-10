import cocotb
from cocotb.triggers import Timer
from cocotb.types import concat
import struct
import hashlib

EXPECTED_SHA256 = 'b93db97286c919817a6fe38a312dff0efee0c5cb8d2b63530f6cc44bfcaad42b'


@cocotb.test()
async def dump(dut):
    h = hashlib.sha256()
    with (open("dump.bin", "wb") as f):
        for addr in range(512):
            dut.A.value = addr

            await Timer(1, units="ns")

            q = 128 + \
                (int(dut.nIAL) << 6) + \
                (int(dut.nCF1) << 5) + \
                (int(dut.nCS51) << 4) + \
                (int(dut.nCSFDC) << 3) + \
                (int(dut.nCS55) << 2) + \
                (int(dut.nCF7) << 1) + \
                int(dut.nCFE)

            b = q.to_bytes(1)
            f.write(b)
            h.update(b)

    assert h.hexdigest() == EXPECTED_SHA256
