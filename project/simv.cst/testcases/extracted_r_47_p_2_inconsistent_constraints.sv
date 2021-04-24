class c_47_2;
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

program p_47_2;
    c_47_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zx0xz101z0011z0z0zx011xx1x1z10zzzxzzxzxzxzzxzzxxzxxxxzzzxxzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
