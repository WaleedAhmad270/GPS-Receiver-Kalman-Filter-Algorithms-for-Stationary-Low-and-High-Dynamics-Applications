function [x, y, z] = lla2ecef_custom(lat, lon, h)
%LLA2ECEF_CUSTOM Convert geodetic latitude, longitude, height to ECEF.
%
%   [x, y, z] = lla2ecef_custom(lat, lon, h)
%
%   lat, lon : radians
%   h        : height [m]
%
%   WGS-84 ellipsoid.

    % WGS-84 parameters
    a  = 6378137.0;               % semi-major axis [m]
    f  = 1/298.257223563;         % flattening
    e2 = f * (2 - f);             % eccentricity squared

    sinLat = sin(lat);
    N = a ./ sqrt(1 - e2 .* sinLat.^2);

    cosLat = cos(lat);
    cosLon = cos(lon);
    sinLon = sin(lon);

    x = (N + h) .* cosLat .* cosLon;
    y = (N + h) .* cosLat .* sinLon;
    z = (N .* (1 - e2) + h) .* sinLat;
end
