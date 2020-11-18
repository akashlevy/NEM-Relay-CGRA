from __future__ import print_function
import sys
import os

def main():
    if len(sys.argv) != 3 and len(sys.argv) != 4:
        print("Usage:", sys.argv[0], "<design_out.raw>", "[1bit_out.raw]", "<halide_out.raw>",
              file=sys.stderr)
        exit(1)

    if len(sys.argv) == 3:
        design_out = sys.argv[1]
        onebit_out = "/dev/null"
        halide_out = sys.argv[2]
        no_onebit = True
    else:
        design_out = sys.argv[1]
        onebit_out = sys.argv[2]
        halide_out = sys.argv[3]
        no_onebit = False

        # sometimes the one bit output may not exist.
        if not os.path.isfile(onebit_out):
            onebit_out = "/dev/null"
            no_onebit = True

    compare_size = os.path.getsize(halide_out)

    with open(design_out, "rb") as design_f:
        with open(halide_out, "rb") as halide_f:
            with open(onebit_out, "rb") as onebit_f:
                pos = 0
                skipped_pos = 0
                while True:
                    design_byte = design_f.read(1)
                    onebit_byte = onebit_f.read(1)
                    if not design_byte:
                        break
                    pos += 1
                    design_byte = ord(design_byte)
                    onebit_byte = ord(onebit_byte) if not no_onebit else 1
                    if onebit_byte != 1:
                        skipped_pos += 1
                        continue
                    halide_byte = ord(halide_f.read(1))
                    if design_byte != halide_byte:
                        # pos in 7-digit ocatal to match od output
                        print("pos: %07o"          % pos,         file=sys.stderr)
                        print("skipped_pos: %07ox" % skipped_pos, file=sys.stderr)
                        print("design:",           design_byte,   file=sys.stderr)
                        print("halide:",           halide_byte,   file=sys.stderr)
                        raise Exception("Error at pos " + str(pos))

    compared_size = pos - skipped_pos
    if compared_size != compare_size:
        raise Exception("Expected to produce " + str(compare_size) + \
                        " valid bytes, got " + str(compared_size))
    print("PASS: compared with", pos - skipped_pos, "bytes")
    print("Skipped", skipped_pos, "bytes")


if __name__ == "__main__":
    main()
