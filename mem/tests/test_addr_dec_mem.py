import cocotb
from cocotb.triggers import Timer
from cocotb.types import concat
import struct
import hashlib

EXPECTED_SHA256 = 'c1fbfc4ead60fd19b1cf888c95293dc22798990125757b8f9ef23248da7fca14'


@cocotb.test()
async def dump(dut):
    h = hashlib.sha256()
    with (open("dump.bin", "wb") as f):
        for idx in range(512):
            dut.A.value = idx & 0x3F
            dut.BOOT.value = (idx >> 6) & 1
            dut.f7_q1.value = (idx >> 7) & 1
            dut.RELOK.value = (idx >> 8) & 1

            await Timer(1, units="ns")

            q = 128 + 64 + \
                (int(dut.nIAH) << 5) + \
                (int(dut.nROM2) << 4) + \
                (int(dut.nDR) << 3) + \
                (int(dut.nRS) << 2) + \
                (int(dut.nROM3) << 1) + \
                int(dut.nROM1)

            b = q.to_bytes(1)
            f.write(b)
            h.update(b)

    assert h.hexdigest() == EXPECTED_SHA256
