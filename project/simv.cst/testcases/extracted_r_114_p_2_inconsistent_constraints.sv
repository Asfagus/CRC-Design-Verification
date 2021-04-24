class c_114_2;
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

program p_114_2;
    c_114_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xxzz10z11x1xzzz0x1z110zx0zx11zx1zxzzxxzxzzxzxxzzxzxxzxxxxzxzxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
