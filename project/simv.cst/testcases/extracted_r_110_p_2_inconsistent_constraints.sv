class c_110_2;
    rand bit[7:0] data_8_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_8_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_8_ != 8'hbc);
    }
endclass

program p_110_2;
    c_110_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1z1zz1xzx01000z0z1zx1x0z1x11z100xxzzzzxxxzxzxzxzzxzzxzxzxzzzxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
