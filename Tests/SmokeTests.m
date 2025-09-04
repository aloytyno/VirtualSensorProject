classdef SmokeTests < matlab.unittest.TestCase
    
    properties (TestParameter)
        DemoFile = struct( ... 
			'VirtualSensorModel', {@VirtualSensorModel});
    end    
    
    methods (TestClassSetup)
        
        % Shut off graphics warnings
        function suppressWarnings(testCase)            
            warnids = ["MATLAB:hg:AutoSoftwareOpenGL" ...
                       % Add additional warning IDs here 
                       ]; %#ok<NBRAK2>    
            import matlab.unittest.fixtures.SuppressedWarningsFixture
            testCase.applyFixture(SuppressedWarningsFixture(warnids))

        end
        
        % Close any new figures created by doc
        function saveExistingFigures(testCase)            
            existingfigs = findall(groot, 'Type', 'Figure');
            testCase.addTeardown(@()delete(setdiff(findall(groot, 'Type', 'Figure'), existingfigs)))
            
        end
        
    end
    
    methods (Test)
        
        function demoShouldNotWarn(testCase, DemoFile)       
            testCase.verifyWarningFree( @() openAndRun(testCase,DemoFile) );
        end
        
    end

    methods

        function openAndRun(~,DemoFile)
            d = [func2str(DemoFile),'.mlx'];
            cp = currentProject;
            f = char(fullfile(cp.RootFolder,"Demos",d));
            % edit(f);
            matlab.internal.liveeditor.executeAndSave(f);
            % export(f);
            % matlab.desktop.editor.getAll().closeNoPrompt;
        end

    end

end
