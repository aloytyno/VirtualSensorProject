function AirSpeed = predictAirSpeed(FlightData)

FlightData = mat2cell(FlightData,size(FlightData,1),ones(1,size(FlightData,2)));
FlightData = cell2table(FlightData);
FlightData.Properties.VariableNames = {'Time','FuelQuantity','OilPressure','OilTemperature','LatitudePosition','LongitudePosition','Altitude','ExhaustTemperature','FuelFlow','FanSpeed','TrueAirSpeed','WindDirection','WindSpeed','WeightOnWheels'};

predictorNames = {'FuelQuantity', 'OilPressure', 'OilTemperature', 'Altitude', 'ExhaustTemperature', 'FuelFlow', 'FanSpeed', 'WindDirection', 'WindSpeed'};
FlightData = FlightData(:, predictorNames);
varnames = FlightData.Properties.VariableNames;
FlightData = varfun(@(x) extractCellData(x),FlightData);
FlightData.Properties.VariableNames = varnames;
persistent model

if isempty(model)
    model = load('model.mat');
end

AirSpeed = model.model.predictFcn(FlightData);
end

function out = extractCellData(in)

    out = in{1};
end