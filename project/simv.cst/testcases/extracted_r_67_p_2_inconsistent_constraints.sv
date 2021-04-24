class c_67_2;
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

program p_67_2;
    c_67_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "001x0x00xz10x1zxx1zxzx1x0111x1z0zzxxzzxxzxzzxxzxxzxzzxzxzzzzzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
