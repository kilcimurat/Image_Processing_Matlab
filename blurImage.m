function img = blurImage(file, row, column)
    image = file;
    % Get the dimensions of the image
    [s1, s2, s3] = size(image);
    % Extract the red, green, and blue channels and convert them to double
    r = im2double(image(:,:,1));
    g = im2double(image(:,:,2));
    b = im2double(image(:,:,3));
    % Get the values of ROWKnob and COLUMNKnob from the app
    a = int32(row);
    a2 = int32(column);
    % Create a filter of size (a, a2) and normalize it
    filter = ones(a, a2);
    filter = double(filter / sum(filter(:)));
    % Initialize matrices to store the filtered channels
    finak = zeros(size(r));
    final2 = zeros(size(r));
    final3 = zeros(size(r));
    % Determine the endpoint for looping
    endpoint = size(r, 1);
    endpoint2 = size(r, 2);
    % Calculate the remainder when s1 and s2 are divided by a and a2, respectively
    extra = rem(s1, a);
    extra2 = rem(s2, a2);
    
    for i = 1:a:endpoint - extra
        for j = 1:a2:endpoint2 - extra2
            filtering1 = r(i:i+(a-1), j:j+(a2-1)) .* filter;
            for z = 1:a
                for z2 = 1:a2
                    finak(i+z-1, j+z2-1) = sum(filtering1(:));
                end
            end
            filtering2 = g(i:i+(a-1), j:j+(a2-1)) .* filter;
            for z = 1:a
                for z2 = 1:a2
                    final2(i+z-1, j+z2-1) = sum(filtering2(:));
                end
            end
            filtering3 = b(i:i+(a-1), j:j+(a2-1)) .* filter;
            for z = 1:a
                for z2 = 1:a2
                    final3(i+z-1, j+z2-1) = sum(filtering3(:));
                end
            end
        end
    end
    a3 = extra;
    a4 = a2;
    filter2 = ones(a3, a4);
    filter2 = double(filter2 / sum(filter2(:)));
    if extra ~= 0
        if extra ~= 1
            for i = endpoint - extra:a3:endpoint - a3 + 1
                for j = 1:a4:endpoint2 - a4 + 1
                    filtering1 = r(i:i+(a3-1), j:j+(a4-1)) .* filter2;
                    for z = 1:a3
                        for z2 = 1:a4
                            finak(i+z-1, j+z2-1) = sum(filtering1(:));
                        end
                    end
                    filtering2 = g(i:i+(a3-1), j:j+(a4-1)) .* filter2;
                    for z = 1:a3
                        for z2 = 1:a4
                            final2(i+z-1, j+z2-1) = sum(filtering2(:));
                        end
                    end
                    filtering3 = b(i:i+(a3-1), j:j+(a4-1)) .* filter2;
                    for z = 1:a3
                        for z2 = 1:a4
                            final3(i+z-1, j+z2-1) = sum(filtering3(:));
                        end
                    end
                end
            end
        end
    end                     
    a5 = a;
    a6 = extra2;
    filter3 = ones(a5, a6);
    filter3 = double(filter3 / sum(filter3(:)));
    
    if extra2 ~= 0
        if extra2 ~= 1
            for i = 1:a5:endpoint - a5 + 1
                for j = endpoint2 - extra2:a6:endpoint2 - a6 + 1
                    filtering1 = r(i:i+(a5-1), j:j+(a6-1)) .* filter3;
                    for z = 1:a5
                        for z2 = 1:a6
                            finak(i+z-1, j+z2-1) = sum(filtering1(:));
                        end
                    end
                    filtering2 = g(i:i+(a5-1), j:j+(a6-1)) .* filter3;
                    for z = 1:a5
                        for z2 = 1:a6
                            final2(i+z-1, j+z2-1) = sum(filtering2(:));
                        end
                    end
                    filtering3 = b(i:i+(a5-1), j:j+(a6-1)) .* filter3;
                    for z = 1:a5
                        for z2 = 1:a6
                            final3(i+z-1, j+z2-1) = sum(filtering3(:));
                        end
                    end
                end        
            end
        end
    end
    if extra ~= 0 && extra2 ~= 0
        if extra ~= 1 && extra2 ~= 1
            for i = endpoint - extra + 1:extra:endpoint
                for j = endpoint2 - extra2 + 1:extra2:endpoint2
                    a = extra;
                    a2 = extra2;
                    filter = ones(a, a2);
                    filter = double(filter / sum(filter(:)));
                    filtering1 = r(i:i+(a-1), j:j+(a2-1)) .* filter;
                    for z = 1:a
                        for z2 = 1:a2
                            finak(i+z-1, j+z2-1) = sum(filtering1(:));
                        end
                    end
                    filtering2 = g(i:i+(a-1), j:j+(a2-1)) .* filter;
                    for z = 1:a
                        for z2 = 1:a2
                            final2(i+z-1, j+z2-1) = sum(filtering2(:));
                        end
                    end
                    filtering3 = b(i:i+(a-1), j:j+(a2-1)) .* filter;
                    for z = 1:a
                        for z2 = 1:a2
                            final3(i+z-1, j+z2-1) = sum(filtering3(:));
                        end
                    end
                end
            end
        end
    end
    img = cat(3, finak, final2, final3);
end
