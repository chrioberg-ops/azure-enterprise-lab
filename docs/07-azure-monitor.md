# Azure Monitor

## Purpose

Azure Monitor is used to collect operational and performance data from DC01.

The monitoring solution helps administrators detect problems, investigate events and evaluate server health.

## Architecture

The monitoring configuration consists of:

| Component | Purpose |
|---|---|
| Log Analytics workspace | Stores and queries collected monitoring data |
| Azure Monitor Agent | Collects data from the Windows Server VM |
| Data Collection Rule | Defines which logs and performance counters are collected |
| DCR association | Connects the rule to DC01 |

## Log Analytics Workspace

| Property | Value |
|---|---|
| Name | law-nordicit-lab |
| Region | Sweden Central |
| Pricing tier | PerGB2018 |
| Retention | 30 days |

The retention period was limited to 30 days to reduce unnecessary storage costs in the lab environment.

## Data Collection Rule

The Data Collection Rule is named:

`dcr-dc01-monitoring`

The rule collects selected Windows events from:

- Application
- System

Only Critical, Error and Warning events are collected.

## Performance Counters

The following performance counters are collected every 60 seconds:

- Total processor usage
- Available memory
- Free disk space

This provides basic visibility into CPU, memory and storage health without collecting unnecessary data.

## Validation

### Azure Monitor Agent

Heartbeat data was received from:

`DC01.corp.nordicit.local`

Agent version:

`1.44.0.0`

### Windows Events

Windows System warning events were successfully received in the Event table.

### Performance Data

The following data was successfully received in the Perf table:

| Counter | Example observed value |
|---|---|
| Processor usage | Approximately 4.62 percent |
| Available memory | Approximately 5775 MB |
| Free disk space | Approximately 48 percent |

## Result

**PASS**

DC01 successfully sends heartbeat, Windows event and performance data to Azure Monitor.
