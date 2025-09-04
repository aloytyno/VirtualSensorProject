% Set up python path
% function setUpPyPath
pathToAQ = fileparts(which('net.py'));
if count(py.sys.path,pathToAQ) == 0
    insert(py.sys.path,int32(0),pathToAQ);
    insert(py.sys.path,int32(0),'C:\Users\aloytyno\OneDrive - MathWorks\Desktop\Demos\Modules\low-code-data-analysis\nasa-aircraft-low-code\Demos\pythonModeling.py');
end