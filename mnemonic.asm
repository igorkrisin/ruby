#square
ORG 0
LOAD =4
CALL 8
ORG 8
DATA 42
STORE 12
MUL 12
BR @8
#...


#factorial
#ORG 0
#вот тут ячейка с адресом возврата (22 line)
#LOAD =5 #0
#STORE 12 #1 сохраняем исходные значения (5) в 11 ячейке
#SUB 11   #2 вычитаем 1
#BREQ 9   #3
#STORE 13 #4 сохраняем 4 в 12 ячейке
#MUL 12   #5 умножаем 5 на 4
#STORE 12 #6
#LOAD 13 #7 загружаем 12 ячейку
#BR 2    #8 прыжок в 1 ячейку
#LOAD 12 #9
# возврат на ардес, сохраненный в стрке 4
#HALT    #10
#DATA 1  #11


#...
#CALL 4 line
#+++
#...


#TODO Было бы неплохо сделать массив адресов, который будет говорить какие ячейки памяти трассировать
#умножение при помощи immediate (проверяю работоспособность умножения)
#ORG 0
#LOAD =5
#MUL 3
#HALT
#DATA 5

#сложение при помощи immediate mode
#ORG 0
#LOAD =2
#ADD 2
#HALT
#DATA 5

#от 10 до 0 уменьшаем ас с immediate
#ORG 0
#LOAD =10
#SUB 4 
#BREQ 6
#BR 1
#DATA 1
#HALT

#от 10 до 0 уменьшаем ас
#ORG 0
#LOAD 4
#SUB 5 
#BREQ 6
#BR 1
#DATA 10, 1
#HALT

#скачки увеличивающие pc
#ORG 0
#LOAD 3  
#ADD 3
#BR 1
#DATA 1

#3 числа сложить и записать в треюю ячейку
#ORG 0
#LOAD 4
#ADD 5
#ADD 6
#STORE 7
#HALT
#DATA 4,5,6