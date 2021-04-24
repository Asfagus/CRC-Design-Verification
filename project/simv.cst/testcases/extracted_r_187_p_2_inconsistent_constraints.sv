class c_187_2;
    rand bit[7:0] data_5_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_5_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_5_ != 8'hbc);
    }
endclass

program p_187_2;
    c_187_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zz1z10z10xzz11011xzzx10zz0xxz10zxxxzzxzxzzzzzxxxxzxxzzxxxzxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
