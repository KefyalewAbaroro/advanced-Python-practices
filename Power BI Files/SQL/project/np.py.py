def create_array():
    import numpy as np
    
    array = np.array([
        [['a','b','c'], ['d','e','f'], ['g','h','i']],
        [['j','k','l'], ['m','n','o'], ['p','q','r']],
        [['s','t','u'], ['v','w','x'], ['y','z',' ']]
    ])
    return array
#  locate "M"
array = create_array()
print(array[1, 1, 0])  # This will print 'm'
#print(array.ndim)
#located m
print(array[1,1,0])
#print the word dog
print(array[0,1,0]+array[1,1,2]+array[0,2,0])
#locate row indices 1 for all blocks
print(array[:, 1,:])
#slice row indices 0 thru 1(outer bound/stop is exclusive)
print(array[:, 0:2, :])
#slice all cols for row indices 1
print (array[:, 1, :])
print(array.shape)

