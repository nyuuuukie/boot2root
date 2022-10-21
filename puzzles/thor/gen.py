import re
import sys
import turtle

def turtle(filename):
    f = open(filename)
    with open("./result.py", 'w') as w:
        w.write("import turtle\n")
        w.write("t = turtle.Turtle()\n")
        w.write("t.speed(5)\n")
        for line in f:
            if line.startswith("Tourne gauche"):
                n = re.findall(r'\d+', line)
                w.write("t.left(" + n[0] + ")\n")
            elif line.startswith("Avance"):
                n = re.findall(r'\d+', line)
                w.write("t.forward(" + n[0] + ")\n")
            elif line.startswith("Tourne droite"):
                n = re.findall(r'\d+', line)
                w.write("t.right(" + n[0] + ")\n")
            elif line.startswith("Recule"):
                n = re.findall(r'\d+', line)
                w.write("t.backward(" + n[0] + ")\n")
            else:
                print(line)
    f.close()
    w.close()

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    turtle(sys.argv[1])