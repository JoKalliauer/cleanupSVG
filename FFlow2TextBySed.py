# !/usr/bin/env python3

import sys
import unicodedata

#inputfile = "in.svg"
#outputfile = "out.svg"

inputfile = (sys.argv[1])
outputfile = (sys.argv[2])
# python3 ./FFlow2TextBySed.py $i2 $i3

with open(inputfile, "r+", encoding='utf-8') as fp:
    alllines = fp.readlines()
    for i in range(len(alllines)):
        line = alllines[i]
        alllines[i] = unicodedata.normalize('NFC', alllines[i])
        if "<g" in alllines[i]:
            line = alllines[i]
            tags = line.replace(">", "<")
            tags = tags.split("<")
            # print(line)
            flowParaNR = -10
            for i3 in range(len(tags)):
                tag = tags[i3].strip()
                # words = words.split(" ")
                # print(tag)
                if tag == "":
                    pass
                else:
                    tag = tag.split(" ")
                    for attribute in tag:
                        # print(attribute)
                        if attribute[0:11] == 'font-size=\"':
                            fs = attribute[11:]
                            # fs = fs.replace(">", " ")
                            fs = fs.strip()
                            fs = fs.split('"')
                            fs = fs[0]
                            fs = fs.replace("px", " ")
                            fs = float(fs)
                            # print(fs)
        if "<flowRoot" in alllines[i]:
            line = alllines[i]
            tags = line.replace(">", "<")
            tags = tags.split("<")
            # print(line)
            flowParaNR = -10
            for i3 in range(len(tags)):
                tag = tags[i3].strip()
                # words = words.split(" ")
                # print(tag)
                if tag == "":
                    pass
                else:
                    tag = tag.split(" ")
                    for attribute in tag:
                        # print(attribute)
                        if attribute[0:11] == 'font-size=\"':
                            fs = attribute[11:]
                            # fs = fs.replace(">", " ")
                            fs = fs.strip()
                            fs = fs.split('"')
                            fs = fs[0]
                            fs = fs.replace("px", " ")
                            fs = float(fs)
                            # print(fs)
                    if tag[0] == 'flowRoot':
                        flowRoottags = tag[1:]
                        cflowRoottags = " ".join(flowRoottags)
                        # print(cflowRoottags)
                    elif tag[0] == 'rect':
                        rx = 0.0  # Default value if there is no x
                        ry = 0.0  # Default value if there is no y
                        for attribute in tag:
                            if attribute[0:3] == 'x=\"':
                                # print(attribute)
                                rx = attribute[3:]
                                # tx = tx.replace(">", " ")
                                rx = rx.strip()
                                rx = rx.split('"')
                                rx = rx[0]
                            elif attribute[0:3] == "y=\"":
                                ry = attribute[3:-1].strip()
                        tx = float(rx)
                        # print(tx)
                    elif tag[0] == 'flowPara':
                        flowParatags = tag[1:]
                        cflowParatags = " ".join(flowParatags)
                        flowParaNR = i3
                        ty = float(ry) + .88476562*fs
                    elif i3 == flowParaNR+1:
                        # print(tag)
                        flowParaText = " ".join(tag[0:])
                        # print(flowParaText)
            line = "<text x=\""+str(tx)+"\" y=\""+str(ty) + \
                "\" "+str(cflowRoottags)+">" + \
                "<tspan x=\""+str(tx)+"\" y=\""+str(ty)+"\" " + \
                str(cflowParatags)+">"+str(flowParaText)+"</tspan></text>\n"
            alllines[i] = line
        # end if "<flowRoot" in alllines[i]:
    dateiX = "".join(alllines)
    # print(dateiX)
fp.close()
fp2 = open(outputfile, "w", encoding='utf-8')
fp2.write(dateiX)
fp2.close()


# sed -ri "s/<flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*<flowRegion([-[:alnum:]=:\" #;\.%\',]*)>[[:space:]]*<rect([-[:lower:][:digit:]\"= \.:;]*) x=\"([-[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([-[:alnum:]=\.\" \#:;\',]*)\/>[[:space:]]*<\/flowRegion>[[:space:]]*<flowPara([-[:alnum:]\.=\" \:\#;\%]*)>([-[:alnum:] \{\}\(\)\+\ \ \.\?\']+)<\/flowPara>[[:space:]]*<\/flowRoot>/<text x=\"\4\" y=\"\5\"\1><tspan x=\"\4\" y=\"\5\"\7>\8<\/tspan><\/text>/g" $i


# <flowRoot([-[:alnum:]\.=\" \:\(\)\%\#\,\';]*)>[[:space:]]*
#  <flowRegion([-[:alnum:]=:\" #;\.%\',]*)>[[:space:]]*
#   <rect([-[:lower:][:digit:]\"= \.:;]*) x=\"([-[:digit:]\. ]+)\" y=\"([-[:digit:]\. ]+)\"([-[:alnum:]=\.\" \#:;\',]*)\/>[[:space:]]*
#  <\/flowRegion>[[:space:]]*
#  <flowPara([-[:alnum:]\.=\" \:\#;\%]*)>
#  ([-[:alnum:] \{\}\(\)\+\ \ \.\?\']+)
#  <\/flowPara>[[:space:]]*
# <\/flowRoot>
# /
# <text x=\"\4\" y=\"\5\"\1><tspan x=\"\4\" y=\"\5\"\7>\8<\/tspan><\/text>/g" $i
