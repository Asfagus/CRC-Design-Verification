class c_10_2;
    rand bit[7:0] data_7_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_7_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_7_ != 8'hbc);
    }
endclass

program p_10_2;
    c_10_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x00xz0x0101zx00x1x0zx11xzx010z1xzxzxzxzzxxzzxzxxzxxzxzzxxxxzzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
