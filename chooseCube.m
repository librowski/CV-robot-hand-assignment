function [choice, new_options] = chooseCube(cube_options)
    [choice , ~] = listdlg('ListString', cube_options, 'Name', 'Select next cube', 'SelectionMode', 'single');
    indexes = cube_options ~= cube_options(choice);
    choice = cube_options(choice);
    new_options = cube_options(indexes);
end

