class c_53_2;
    rand bit[7:0] data_9_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_9_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_9_ != 8'hbc);
    }
endclass

program p_53_2;
    c_53_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0zz01z10010xx0zz1x0x10z1xxx111xxzxxzxzzxxxxzzzzxzzzxxxzxzxxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
