-- Write a select statement that takes name from person table and return "Hello, <name> how are you doing today?" results in a column 
-- named greeting

select concat('Hello, ', name, ' how are you doing today?') as greeting from person 

/* plus some python :)

def greet(name):
    return f"Hello, {name} how are you doing today?" */
