function FlightData = importFlightData(workbookFile, sheetName, dataLines)
    % IMPORTFLIGHTDATA Function to import flight data from an Excel file
    %
    % Input Arguments:
    %     workbookFile - path to the Excel file
    %     sheetName - name or index of the sheet to read from (optional)
    %     dataLines - range of rows to read (optional)
    %
    % Output Arguments:
    %     FlightData - table containing the imported flight data
    %
    % Example Usage:
    %     % Import data from the first sheet, rows 2 to 47313
    %     data = importFlightData('flight_data.xlsx');
    %
    %     % Import data from a specific sheet and specific rows
    %     data = importFlightData('flight_data.xlsx', 'Sheet2', [2, 100]);

    % Set default sheet name if not provided
    if nargin == 1 || isempty(sheetName)
        sheetName = 1;
    end
    % Set default data range if not provided
    if nargin <= 2
        dataLines = [2, 47313];
    end
    % Define import options for the spreadsheet
    opts = spreadsheetImportOptions("NumVariables", 13);
    opts.Sheet = sheetName;
    opts.DataRange = "A" + dataLines(1, 1) + ":M" + dataLines(1, 2);
    opts.VariableNames = ["Time", "FuelQuantity", "OilPressure", "OilTemperature", "LatitudePosition", "LongitudePosition", "Altitude", "ExhaustTemperature", "FuelFlow", "FanSpeed", "TrueAirSpeed", "WindDirection", "WindSpeed"];
    opts.VariableTypes = ["datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
    % Set the input format for the 'Time' variable
    opts = setvaropts(opts, "Time", "InputFormat", "");
    % Read the initial data from the specified range
    FlightData = readtable(workbookFile, opts, "UseExcel", false);
    % Loop through additional data lines and append to the FlightData table
    for idx = 2:size(dataLines, 1)
        opts.DataRange = "A" + dataLines(idx, 1) + ":M" + dataLines(idx, 2);
        tb = readtable(workbookFile, opts, "UseExcel", false);
        FlightData = [FlightData; tb]; %#ok<AGROW>
    end
end