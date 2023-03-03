function varargout = assignValuesFcn(u, Global, id)

    sen = Global.sen;
    gen = Global.gen;
    n   = Global.n;


    if strcmp(id,'gas_bubble')
        index_1 = gen;
        u_x = u((1):(n*gen));
        varargout = cell(1, index_1);

    elseif strcmp(id,'gas_emulsion')
        index_1 = gen;
        u_x     = u((n*gen + 1):(n*gen*2));
        varargout = cell(1, index_1);

    elseif strcmp(id,'solid_wake')
        index_1   = sen;
        u_x     = u((n*gen*2 + 1):(n*gen*2 + n*sen));
        varargout = cell(1, index_1);

    elseif strcmp(id,'solid_emulsion')
        index_1   = sen;
        u_x     = u((n*gen*2 + n*sen + 1):(n*gen*2 + n*sen*2));
        varargout = cell(1, index_1);

    end


    for i = 1:index_1

        varargout{i} =  u_x((i - 1)*n+1:i*n);

    end

end
