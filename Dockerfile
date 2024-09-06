FROM yugabytedb/yugabyte:2024.1.0.0-b129

WORKDIR /app

ENTRYPOINT ["yugabyted"]
CMD ["start", "--background", "false", "--ui", "false", "--insecure"] 