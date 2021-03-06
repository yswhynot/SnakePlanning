function core = getBasicRrtCore(extend, sample)
    function tree = basicCore(start, goal, obs, debug)
        if(nargin < 3)
            debug = false;
        end
        
        if(debug >= 1)
            scatter(start(1), start(2), 'black', 'filled')
            scatter(goal(1), goal(2), 'green', 'filled')
            numSuccessfulExtends = 0;
            lastPlotted = 1;
            modVal = 1;
        end
        
        tree = Tree();
        tree.points = start;
        tree.parents = 0;
        i = 0;
        while(sqrt(sumsqr(tree.points(end,:) - goal)) > 0.1)
            x_rand = sample(i, goal);
            extend(tree, x_rand, obs);

            if(debug >= 1)
                numSuccessfulExtends = numSuccessfulExtends+1;
            end
            
            if(debug >= 2)
                plotTree(tree,...
                         lastPlotted+1);
                drawnow
                lastPlotted = length(tree.parents);
                if(mod(numSuccessfulExtends,modVal)==0)
                    disp(sprintf('Num Extend Attempts: %d', ...
                                 numSuccessfulExtends));
                    modVal = modVal*10;
                end
            end
            i = i+1;
        end

        if(debug >= 1)
            disp(sprintf('Extended %d times', numSuccessfulExtends));
            disp(sprintf('Tree size: %d', size(tree.points,1)));
            plotTree(tree);
            drawnow
        end
    end
    core = @basicCore;
end
