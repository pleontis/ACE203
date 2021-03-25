# ACE203
Project done in VHDL for course at ECE TUC

------Counter------

The Counter counts from 0 to 255, does not take negative values or values greater than 255. If it takes values outside the range [0,255] then it turns on the output signal (Overflow, Underflow) and freezes its operation until RST and valid output becomes 0



![image](https://user-images.githubusercontent.com/67234862/112509944-a1dc1580-8d99-11eb-9a26-0b889e7b6bfd.png)



------Finite State Machine (FSM)------



![image](https://user-images.githubusercontent.com/67234862/112506513-83c0e600-8d96-11eb-9927-df41a6511e28.png)



-----Memory------

The circuit will have 4-bit memory and a depth of 12 memory slots. The stack will function with proper control as a stack of 10 items. Each number in the input will be stored
in the stack when the Push key is pressed. Each time the Pop key is pressed, the number on the head of the stack is deleted. The NumberOUT output of the stack will be the stack
head unless it is empty then it will be the 0 position of the memory. When the stack is empty the Empty output will light up and every time it is full, ie it has 10 items, the
Full one will light up. When the stack is empty no one will be able to remove items and when it is full they will not be able to add items respectively. Important: In stacks
with n memory elements we can store (n -1) data because otherwise we miss the pointers. We solve the problem by making a memory depth of 12 places but using only 11 of them
(for 10 useful items). Position 0 for empty stack, positions 1-10 for storage, position 11 unused. In addition we have the AlmostEmpty and AlmostFull outputs, which become 1 if
we have stored (respectively) 1-3 or 8-10 data. We use pre-increment / post -decrement because TOSPointer at any time can be the address of the memory we show on the screen.
