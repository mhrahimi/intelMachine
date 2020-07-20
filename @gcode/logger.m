function logger(obj)
obj.log = [obj.log; struct2table(obj.last)]; 
end