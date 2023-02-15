function [t_close, ind_t] = find_closest_timestamp(t0, ts)

    [val, ind_t] = min(abs(t0-ts));
    t_close=ts(ind_t);
end