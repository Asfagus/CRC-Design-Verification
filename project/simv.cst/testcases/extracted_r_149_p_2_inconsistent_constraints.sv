class c_149_2;
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

program p_149_2;
    c_149_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zxz1z10x1z011x1zx011xx1x0zz0zx01xxzxxxzxxzzzzzzxxzxxzxxzzzxxxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
