class c_115_2;
    rand bit[7:0] data_6_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_6_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_6_ != 8'hbc);
    }
endclass

program p_115_2;
    c_115_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x1xz1z0z0x0101z11x1x100z00001x11xzzxzxxxxzxxxzzxxzzxzzxxzzxzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
