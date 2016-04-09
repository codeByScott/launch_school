# Assessment One

## Local Variables
1. The variable str was modified within the loop, 
   this shows how you can modify an outside variable from 
   within a block.  
   
2. This code raises an exception because of scope.  The variable is
   initialized within the block and therefore cannot be called
   outside of the block's local scope.  
   
3. It is uncertain whether the code snippet will run.  This is because
   we do not know if the variable str was initialized outside of the loop.
  
4. This code raises an exception, because the variable str is not
   defined within the #a_method's scope.  For this to work the #a_method
   could take the str as an argument. 

5. This code does not raise an exception like the previous one because this code first calls the #a_method,
   which returns "world". It then calls the method puts with the str as a parameter, which returns "hello".
   The previous code example called the #a_method which contained an undefined variable. This is all due to 
   scope.  
     
   The str variable outside of #a_method and the str variable within the #a_method
   are completely different objects with unique object ids.  They do not share the same scope.
   
6. The variable b is pointing to the "hello" object, not the a variable.  The a variable was changed to point to 
   the "hi" object and then appended the " world" object to the "hi" object, but that does not change
   where the b variable is pointing.  
   
7. There are four variables: a, b, c, and d.  There are two objects: "hello" and "world". 
   By checking the object_id's it is easy to determine which id's are unique and which are the same.
   The variables a, b, and c point to the same object_id, which happens to be "hello".  The d variable
   points to a different object_id, which is the "world" object.
   
## Mutating Method Arguments
1. The last line in the below code prints "hello", because it is calling the puts method with a parameter of
   greeting.  The greeting variable is set to "hello".  The #change does not mutate its parameter, therefore if you
   were expecting puts greeting to print "hello world" you would be incorrect.  This demonstrates how you can use
   a variable within a method, without destructive side effects on the variable.
   
2. The last line prints "hello world" because the #change mutates the object that the greeting variable points to.  
   This demonstrates a destructive action by using the shovel method.  
   
3. The last line prints "hello", because it is calling the greeting variable which is pointing to the "hello" object.
   By setting the param to "hi" the #change initialized its own variable within its local scope, thereby not mutating the greeting variable.
   
4. The #change is actually returning the "hi world" object.  This is because param is pointing to "hi" and then gets " world" appended to it.
   Because param is initialized within the scope of #change, it does not mutate the greeting variable.  
   
## Working with Collections
1. The array#map iterates through the items in a given array and returns a new array based on the return value of the block. Each item is changed based on the return value of the block.

2. The array#select iterates through the given array and returns a new array.  If the return value of the item is true, the item is selected.    

3. Both of the operations are concatenations and essentially return the same values.  Both n + 1 and n += 1 return a new number.  Because the code is using the array#map, I would use n + 1, as it is more efficient and will return the same value.  Using n += 1, is the same as n = n + 1.

4. The array#map returns a new array based on the return value of the block.  Since the return value of this block is a boolean it will return true or false.  

5. The array#map return a new array based on the return value of the block.  Since the return value of this block is a string it will return nil. 

6. The array#select is looking for truthy values and if the item is true it returns the item.  Since n + 2 will return true for each item in this array, it simply returns the value.  Using array#map would return the intended solution in this case.  

7. This code is going to return an empty array.  This is because puts n returns nil.  Nil is considered falsey, so using array#select will NOT select any of the values in this array.  