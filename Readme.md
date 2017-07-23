
# PSIS - Powershell Integration Services

PSIS is a simple tool to create powershell based load processes with SQL and Powershell scripts and dependencies between them.

## Use Cases

### UC1 - Create a new batch load

The user creates a new Powershell-Project in Visual Studio and wants to:
- Initialize it as a PSIS project.
- Create a SQL script as first job step.
- Execute the job against a database.

## Roadmap

- [x] Create and run simple loads
- [ ] Add logging
- [ ] Continue load
- [ ] Azure readyness

## Contributing to PSIS

### Tests

First install Pester `Install-Module Pester`.
Then run `Invoke-Pester` or run all tests in Visual Studio.
