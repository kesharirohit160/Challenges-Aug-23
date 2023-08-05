
#######################   Challenge #  3#################################

# ## We have a nested object. We would like a function where you pass in the object and a key and get back the value.
# ### The choice of language and implementation is up to you.

# #### Dictionary - Dictionaries are used to store data values in key:value pairs. I will use Dictionary to solve this challenge.


########################################################

# Below is fundtion which I used and will pass the object and key and it will return the value as per Key.

# I used try and except as well so that if any error is there code will not give error and it will retrun none.
        # The try block lets you test a block of code for errors.
        # The except block lets you handle the error.

def find_nested_value(obj, key):
    keys = key.split('/')
    value = obj
    
    for k in keys:
        try:
            value = value[k]
        except (TypeError, KeyError):
            return None
    
    return value


########################################################


# I am giving here the input
object1 = {'a':{'b':{'c':'d'}}}
key1 = 'a/b/c'

#lets call the the fuction with input
value = find_nested_value(object1,key1)

# print the return value 
print(" Object -: ", object1 )
print(" Key -: ", key1 )
print(" value -: ", value)
print("####################################################")

###############################################s#########

# I am giving here the input
object1 = {'x':{'y':{'z':'a'}}}
key1 = 'x/y/z'

#lets call the the fuction with input
value = find_nested_value(object1,key1)

# print the return value 
print(" Object -: ", object1 )
print(" Key -: ", key1 )
print(" value -: ", value)
print("####################################################")

########################################################


# Input
object1 = {'x':{'y':{'z':'a'}}}
key1 = 'x/y'

#lets call the the fuction with input
value = find_nested_value(object1,key1)

# print the return value 
print(" Object -: ", object1 )
print(" Key -: ", key1 )
print(" value -: ", value)
print("####################################################")




#Input
object1 = {'a':{'b':{'c':'d'}}}
key1 = 'a/b'

#lets call the the fuction with input
value = find_nested_value(object1,key1)

# print the return value 
print(" Object -: ", object1 )
print(" Key -: ", key1 )
print(" value -: ", value)
print("####################################################")




# Input
object1 = {'a':{'b':{'c':'d'}}}
key1 = 'c'

#lets call the the fuction with input
value = find_nested_value(object1,key1)

# print the return value 
print(" Object -: ", object1 )
print(" Key -: ", key1 )
print(" value -: ",value)
print("####################################################")





# Input
object1 = {'a':{'b':{'c':'d'}}}
key1 = 'e'

#lets call the the fuction with input
value = find_nested_value(object1,key1)

# print the return value 
print(" Object -: ", object1 )
print(" Key -: ", key1 )
print(" value -: ",value)
print("####################################################")

# # Thank you
