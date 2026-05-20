# Cloud Networking Observability Skill Walkthrough

Learn how to extend **Gemini CLI** with the **Google Cloud Networking Observability** skill and watch the agent perform real-world network diagnostics directly in your terminal.

---

## Step 1: Introduction
The **Google Cloud Networking Observability** skill gives Gemini CLI specialized instructions to:
* Query and pivot VPC Flow Logs in BigQuery.
* Analyze Firewall Logs to find blocked traffic.
* Create and check Network Management Connectivity Tests.
* Query Cloud NAT metrics and connection logs.

In this walkthrough, you will install the CLI, link this skill, and run live prompts to see the agent in action.

---

## Step 2: Setup Environment
Run the following script to verify your environment, install Gemini CLI, link the Networking skill, and enable auto-approval policies for a seamless experience:

```sh
chmod +x ./verify-env.sh && ./verify-env.sh
```

---

## Step 3: Run a Live Diagnostic Prompt
Now, let's run a real-world network analysis prompt from the evaluation suite. 

Since you are an internal user, you have access to the playground projects. The agent will use your credentials to run `gcloud` commands and query BigQuery.

### Prompt 1: VPC Flow Logs Top Talker
Ask the agent to identify the VM sending the most traffic in `cn-fe-playground`:

```sh
gemini "In project 'cn-fe-playground', find the VM that has sent the most traffic in the last hour. Then, show me its top 5 destination IPs by byte count."
```

### Prompt 2: Firewall Activity & Denies
Ask the agent to audit blocked traffic in `firewall-logging-prober3`:

```sh
gemini "Show me the top 3 most active firewall rules in project 'firewall-logging-prober3' for the last hour. If any traffic is denied, tell me which rules are responsible and which IPs are blocked."
```

---

## Step 4: Observe the Agent's Behavior
While the agent is running, watch its terminal output closely. You will see:

1. **Skill Activation:** The agent recognizes the task matches the linked skill and loads its instructions.
2. **Tool Selection:** The agent automatically decides to use BigQuery or Cloud Logging.
3. **Command Generation:** The agent drafts and executes `gcloud` or `bq` commands to query logs.
4. **Reasoning Loop:** The agent parses the output, pivots the data, and continues its investigation until it finds the answer.

---

## Step 5: Clean Up (Optional)
If you want to unlink the skill from your workspace:

```sh
gemini skills uninstall google-cloud-networking-observability
```
