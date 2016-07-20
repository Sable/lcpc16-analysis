
import os
import csv
import numpy as np
import matplotlib.pyplot as plt
from math import log

fileTag = ""
title = ""
compiler = ""
# implementation = ['matlab','matlab-tameir','matlab-plus-no','matlab-plus', 'matlab-mixed']

def main(fileName, op):
    # fileName = 'report-mac.log'
    skipLine = [11,12,12]
    csvTable = readCSV(fileName,skipLine[op-1])
    process(csvTable, op)
    return

def process(csvTable, op):
    benchmarks = ['backprop','blackscholes','capr','crni','fft','nw','pagerank','mc','spmv']
    shortName  = ['bp', 'bs', 'capr','crni','fft','nw','pagerank','mc','spmv']
    
    if op==1:
        processFormat1(csvTable, benchmarks, shortName, 'matlab-2013')
        processFormat1(csvTable, benchmarks, shortName, 'matlab-vm')
    elif op==2:
        processFormat2(csvTable, benchmarks, shortName, 'matlab-2013')
    elif op==3:
        processFormat2(csvTable, benchmarks, shortName, 'octave-4.0')
    return

def processFormat1(csvTable, benchmarks, shortName, targetCompiler):
    print 'format1:'
    benList = []
    implementation = ['matlab','matlab-plus-no','matlab-plus', 'matlab-mixed']
    benCase = len(implementation);
    for x in range(len(benchmarks)):
        benList.append([0]*benCase)
    for row in csvTable:
        if row[0] in benchmarks:
            benListPos = benchmarks.index(row[0])
        else:
            continue
        benName = row[1] #implementation
        benComp = row[2] #compiler
        if benComp != targetCompiler:
            continue
        benSize = 'medium'
        benTime = getTime(row[3])
        # if row[0] == 'blackscholes':
        #     benTime = 0
        benPos  = getPost(benName, benSize, implementation)
        if benPos >= 0:
            benList[benListPos][benPos] = benTime
    # print benList
    print 'matlab-original,matlab-plus-no,matlab-plus,matlab-mixed'
    print '-------------------------------------------------------'
    # prettyPrint(benchmarks, benList)
    for x in range(len(benchmarks)):
        print benchmarks[x],':'
        print ' medium:',getRatio4(benList[x])

def processFormat2(csvTable, benchmarks, shortName, targetCompiler):
    print 'format2:'
    benList = []
    implementation = ['matlab', 'matlab-mixed']
    benCase = len(implementation);
    for x in range(len(benchmarks)):
        benList.append([0]*benCase)
    for row in csvTable:
        if row[0] in benchmarks:
            benListPos = benchmarks.index(row[0])
        else:
            continue
        benName = row[1] #implementation
        benSize = 'medium'
        benTime = getTime(row[2])
        benPos  = getPost(benName, benSize, implementation)
        if benPos >= 0:
            benList[benListPos][benPos] = benTime
    # print benList
    print 'matlab-original, matlab-mixed'
    print '-----------------------------'
    # prettyPrint(benchmarks, benList)
    for x in range(len(benchmarks)):
        print benchmarks[x],':'
        print ' medium:',getRatio2(benList[x])



def plotMediumAll(benList, shortName):
    mediumValue0 = []
    mediumValue1 = []
    mediumValue2 = []
    mediumValue3 = []
    mediumValue4 = []
    N = len(benList)
    for x in range(N):
        oneValue = ratioValue5(benList[x])
        mediumValue0.append(oneValue[0])
        mediumValue1.append(oneValue[1])
        mediumValue2.append(oneValue[2])
        mediumValue3.append(oneValue[3])
        mediumValue4.append(oneValue[4])

    ind = np.arange(N) #location
    width = 0.22       #width
    fig, ax = plt.subplots()
    # figSize = plt.gcf()
    # figSize.set_size_inches(9, 6)
    # kwarg1 = {'hatch':'.'}
    # rects0 = ax.bar(ind, mediumValue0, width, facecolor='#9999ff', edgecolor='white')
    rects1 = ax.bar(ind, mediumValue1, width, facecolor='#9999ff', edgecolor='white')
    # kwarg2 = {'hatch':'/'}
    rects2 = ax.bar(ind+1*width, mediumValue2, width, facecolor='#ff9999', edgecolor='white') #**kwarg2
    rects3 = ax.bar(ind+2*width, mediumValue3, width, facecolor='#fff000', edgecolor='white') #**kwarg2
    rects4 = ax.bar(ind+3*width, mediumValue3, width, facecolor='#000fff', edgecolor='white') #**kwarg2

    ax.set_ylabel('Speedup')
    ax.set_title('Vectorization on ' + title + ' (medium)')
    ax.set_xticks(ind + 2*width)
    ax.set_xticklabels(shortName)

    plt.plot((0,N),(1,1),'b--')

    ax.legend((rects1[0], rects2[0], rects3[0], rects4[0]), ('TameIR','Plus with no checks', 'Plus with checks', 'Mixed'))

    # autolabel(ax,rects0)
    autolabel(ax,rects1)
    autolabel(ax,rects2)
    autolabel(ax,rects3)
    autolabel(ax,rects4)
    # plt.show()
    fig.savefig('figure_'+fileTag+".pdf", dpi=100)

def autolabel(ax,rects):
    # attach some text labels
    for rect in rects:
        height = rect.get_height()
        if height >= 0:
            ax.text(rect.get_x() + rect.get_width()/2., height+0.07,
                    '%.2f' % height,
                    ha='center', va='bottom', fontsize=6)


def ratioValue5(items):
    va,vb,vc,vd,ve = items
    ka = 1
    kb = safeDivide(va, vb)
    kc = safeDivide(va, vc)
    kd = safeDivide(va, vd)
    ke = safeDivide(va, ve)
    return [ka,kb,kc,kd,ke]

def getRatio4(items):
    va,vb,vc,vd = items
    # if va != 0 and vc != 0 and vd != 0:
    return '1:%f:%f:%f (time: %f, %f, %f, %f)' % (safeDivide(va,vb), safeDivide(va,vc), safeDivide(va,vd), va,vb,vc,vd)

def getRatio2(items):
    va,vb = items
    return '1:%f (time: %f, %f)' % (safeDivide(va,vb), va,vb)

def safeDivide(a, b):
    if b == 0:
        return 0
    else:
        return a/b

def getPost(name, size, implementation):
    if name in implementation:
        benchPos= implementation.index(name)
    else:
        return -1
    return benchPos

def getTime(s):
    size = len(s)
    return float(s[:size-1])

def readCSV(fileName, skipLine):
    table = []
    n = 0
    fp = open(fileName, 'r')
    lines = fp.readlines()
    for row in lines:
        if n > skipLine:
            items = []
            for x in row.split('|')[1:9]:
                items.append(x.strip())
            table.append(items)
        n = n + 1
    print len(table),'lines'
    return table



if __name__ == "__main__":
    title = "Lynx-Linux 8 core with R2013 and R2015"
    main('report-linux-lcpc-1-matlab.log',1)
    # ----------------
    title = "Lynx-Linux 8 core with R2013 JIT off"
    main('report-linux-lcpc-1-matlab-no-jit.log',2)
    # ----------------
    title = "Lynx-Linux 8 core with Octave"
    main('report-linux-lcpc-2-octave.log',3)

