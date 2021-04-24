class c_112_2;
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

program p_112_2;
    c_112_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0z10xxxz0z0x11001x0010000z10z110xxzxzxzxzxxzzxxzxzzzzzzxxzzxxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
