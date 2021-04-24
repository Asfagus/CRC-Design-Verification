class c_31_2;
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

program p_31_2;
    c_31_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "110zzx0xz11x1010x00zz1zxxxz1z1x0zxzxzxzxzxxzxzzzzxxxzxxzzxxzzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
