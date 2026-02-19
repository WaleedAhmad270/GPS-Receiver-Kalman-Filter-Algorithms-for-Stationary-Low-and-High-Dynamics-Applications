function [e, n, u] = ecef2enu_custom(x, y, z, lat0, lon0, h0)
%ECEF2ENU_CUSTOM Convert ECEF coordinates to ENU at reference (lat0,lon0,h0).
%
%   [e, n, u] = ecef2enu_custom(x, y, z, lat0, lon0, h0)
%
%   x, y, z : ECEF coordinates [m]
%   lat0, lon0 : reference latitude/longitude [rad]
%   h0         : reference height [m]
%
%   Returns east, north, up [m] in local ENU frame.

    % Reference in ECEF
    [x0, y0, z0] = lla2ecef_custom(lat0, lon0, h0);

    dx = x - x0;
    dy = y - y0;
    dz = z - z0;

    % Precompute trig of reference
    sinLat0 = sin(lat0);
    cosLat0 = cos(lat0);
    sinLon0 = sin(lon0);
    cosLon0 = cos(lon0);

    % ECEF -> ENU rotation matrix
    R = [ -sinLon0,              cosLon0,                0;
          -sinLat0*cosLon0,     -sinLat0*sinLon0,       cosLat0;
           cosLat0*cosLon0,      cosLat0*sinLon0,       sinLat0 ];

    enu = R * [dx(:)'; dy(:)'; dz(:)'];

    e = enu(1, :).';
    n = enu(2, :).';
    u = enu(3, :).';
end
